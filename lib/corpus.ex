defmodule Corpus do
  #use Application.Behaviour

  def start(_type, _args) do
    IO.inspect(_type)
    #Corpus.Supervisor.start_link
    main(_args)
  end

  def main(args) do
    IO.inspect(args)
    if (List.first(args) == "ngrams") do
      Ngrams.report(Enum.at(args,1), 1000, 3)
    else
      process(:help)
    end
  end

  def process(:help) do
    IO.puts """
      Usage:
        corpus-elixir [command] [corpus-directory]

      Options:
        -h, [--help]      # Show this help message and quit.

      Description:
        The corpus tool performs word, n-gram and letter analysis.
    """
    System.halt(0)
  end

end

