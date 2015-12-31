defmodule SipHash.Mixfile do
  use Mix.Project

  @url_docs "http://hexdocs.pm/siphash"
  @url_github "https://github.com/zackehh/siphash-elixir"

  def project do
    [
      app: :siphash,
      name: "SipHash",
      description: "Elixir implementation of the SipHash hash family",
      compilers: [ :make, :elixir, :app ],
      package: %{
        files: [
          "c_src",
          "lib",
          "mix.exs",
          "LICENSE",
          "Makefile",
          "README.md"
        ],
        licenses: [ "MIT" ],
        links: %{
          "Docs" => @url_docs,
          "GitHub" => @url_github
        },
        maintainers: [ "Isaac Whitfield" ]
      },
      version: "2.1.0",
      elixir: "~> 1.1",
      aliases: [
        clean: [ "clean", "clean.make" ]
      ],
      deps: deps,
      docs: [
        extras: [ "README.md" ],
        source_ref: "master",
        source_url: @url_github
      ],
      test_coverage: [
        tool: ExCoveralls
      ],
      preferred_cli_env: [
        coveralls: :test
      ]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      # documentation
      { :earmark, "~> 0.1",  optional: true, only: :docs },
      { :ex_doc,  "~> 0.11", optional: true, only: :docs },
      # testing
      { :benchfella,  "~> 0.3.0", optional: true, only: :test },
      { :benchwarmer, "~> 0.0.2", optional: true, only: :test },
      { :excoveralls, "~> 0.4",   optional: true, only: :test },
      { :exprof,      "~> 0.2.0", optional: true, only: :test }
    ]
  end
end

# Custom clean for C source
defmodule Mix.Tasks.Clean.Make do
  def run(_) do
    { _result, 0 } = System.cmd("make", ["clean"], stderr_to_stdout: true)
  end
end

# Custom compile for C source
defmodule Mix.Tasks.Compile.Make do
  def run(_) do
    { _result, 0 } = System.cmd("make", [], stderr_to_stdout: true)
  end
end
