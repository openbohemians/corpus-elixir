defmodule Corpus.Mixfile do
  use Mix.Project

  def project do
    [ app: :corpus,
      version: "0.0.1",
      elixir: "~> 0.14.0",
      escript_main_module: Corpus,
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [ applications: [],
      mod: { Corpus, [] } ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "~> 0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    []
  end
end
