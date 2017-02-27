defmodule Ecto.Adapter.Storage  do
  @moduledoc """
  Specifies the adapter storage API.
  """

  use Behaviour

  @doc """
  Create the storage in the data store and return `:ok` if it was created
  successfully.

  Returns `{:error, :already_up}` if the storage has already been created or
  `{:error, term}` in case anything else goes wrong.

  ## Examples

    storage_up(username: postgres,
               database: 'ecto_test',
               hostname: 'localhost')

  """
  defcallback storage_up(Keyword.t) :: :ok | {:error, :already_up} | {:error, term}

  @doc """
  Drop the storage in the data store and return `:ok` if it was dropped
  successfully.

  Returns `{:error, :already_down}` if the storage has already been dropped or
  `{:error, term}` in case anything else goes wrong.

  ## Examples

    storage_down(username: postgres,
                 database: 'ecto_test',
                 hostname: 'localhost')

  """
  defcallback storage_down(Keyword.t) :: :ok | {:error, :already_down} | {:error, term}
end
