defmodule Postgrex.ErrorCode do
  # We put this file in the repo because the last real change happened in 2011.
  # https://github.com/postgres/postgres/blob/master/src/backend/utils/errcodes.txt
  @external_resource errcodes_path = Path.join(__DIR__, "errcodes.txt")

  errcodes = for line <- File.stream!(errcodes_path),
                 match?(<<_code::(5*8), "    ", _::binary>>, line) do
    case String.split(line, " ", trim: true) do
      [code, _, _, name] -> {code, name |> String.strip |> String.to_atom}
      [code, _, _] -> {code} # duplicated code without name
    end
  end

  {errcodes, duplicates} = Enum.partition(errcodes, &match?({_, _}, &1))

  # The errcodes.txt file does contain some codes twice, but the duplicates
  # don't have a name. Make sure every every code without a name has another
  # entry with a name.
  for {duplicate} <- duplicates do
    unless Enum.find(errcodes, fn {code, _} -> code == duplicate end) do
      raise RuntimeError, "found errcode #{duplicate} without name"
    end
  end

  @doc ~S"""
  Translates a Postgres error code into a name

  Examples:
      iex> code_to_name("23505")
      :unique_violation
  """
  @spec code_to_name(String.t) :: atom | no_return
  def code_to_name(code)

  for {code, errcodes} <- Enum.group_by(errcodes, HashDict.new, &elem(&1, 0)) do
    [{^code, name}] = errcodes
    def code_to_name(unquote(code)), do: unquote(name)
  end

  @doc ~S"""
  Translates a Postgres error name into a list of possible codes.
  Most error names have only a single code, but there are exceptions.

  Examples:
      iex> name_to_code(:prohibited_sql_statement_attempted)
      "2F003"
  """
  @spec name_to_code(atom) :: [String.t] | no_return
  def name_to_code(name)

  @code_decision_table [
    string_data_right_truncation: "22001",        # 01004 not used
    modifying_sql_data_not_permitted: nil,        # 38002 or 2F002 not used
    prohibited_sql_statement_attempted: "2F003",  # 38003 not used
    reading_sql_data_not_permitted: nil,          # 38004 or 2F004 not used
    null_value_not_allowed: "22004"               # 39004 not used
  ]

  for {name, errcodes} <- Enum.group_by(errcodes, HashDict.new, &elem(&1, 1)) do
    case Keyword.fetch(@code_decision_table, name) do
      {:ok, nil} ->
        :ok
      {:ok, code} ->
        def name_to_code(unquote(name)), do: unquote(code)
      :error ->
        [{code, ^name}] = errcodes
        def name_to_code(unquote(name)), do: unquote(code)
    end
  end
end
