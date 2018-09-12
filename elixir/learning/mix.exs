defmodule Learning.MixFile do
  use Mix.Project

  def project do
    [
      app: :learning,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      applications: [],
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mix_test_watch, "~> 0.3", only: :dev, runtime: false},
      {:mock, "~> 0.3.0", only: :test}
    ]
  end
end
