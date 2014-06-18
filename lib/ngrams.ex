defmodule Ngrams do
  @moduledoc """
  Elixir N-Gram Word Analysis
  """

  def report(dir, max, n=3) do
    stats = parse(dir, n)
    grams = bestngrams(stats, max)
    display(grams)
  end

  @doc "Collect all text files from the given directory."
  def corpus_files(directory) do
    paths = File.ls!(directory)
    Enum.flat_map(paths, fn path ->
      fullpath = Path.join(directory, path)
      if File.dir?(fullpath) do
        corpus_files(fullpath)
      else
        if String.ends_with?(path, ".txt") do
          fullpath
        end
      end
    end)
  end

  def parse(directory, n=3) do
    files = corpus_files(directory)

    texts = Stream.map(files, fn(file) ->
              File.read!(file)
            end)

    grams = Stream.flat_map(texts, fn(text) ->
              Stream.map(phrases(text), fn(phrase) ->
                chunks(words(phrase), n)
              end)
            end)

    stats = Map.new

    Enum.each(grams, fn(gram) ->
      Dict.update(stats, gram, stats[gram] + 1)
    end)

    stats
  end

  def chunks(words, max) do
    Enum.flat_map(2..max, fn(n) ->
      Enum.chunk(words, n, 1)
    end)
  end

  def bestngrams(stats, max) do
    stats_tupled = Map.to_list(stats)
    stats_sorted = Enum.sort(stats_tupled, fn({_, rank}) -> rank end)
    stats_sorted.take(max)
  end

  def display(stats) do
    stats = Enum.sort(stats)
    Enum.each(stats, fn({ngram, rank}) ->
      IO.println("#{rank} #{ngram}")
      #IO.println(ngram)
    end)
  end

  @doc "Returns an iterator over word phrases."
  def phrases(text) do
    Regex.split("[\w\s'-]+", text)
  end

  @doc "Returns an iterator over words."
  def words(text) do
    text = String.lowercase(text)
    Regex.split("[A-Za-z][A-Za-z']*", text)
  end

end
