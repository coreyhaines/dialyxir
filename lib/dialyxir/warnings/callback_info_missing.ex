defmodule Dialyxir.Warnings.CallbackInfoMissing do
  @behaviour Dialyxir.Warning

  @impl Dialyxir.Warning
  @spec warning() :: :callback_info_missing
  def warning(), do: :callback_info_missing

  @impl Dialyxir.Warning
  @spec format_short([String.t()]) :: String.t()
  def format_short(args), do: format_long(args)

  @impl Dialyxir.Warning
  @spec format_long([String.t()]) :: String.t()
  def format_long([behaviour]) do
    pretty_behaviour = Erlex.PrettyPrint.pretty_print(behaviour)

    "Callback info about the #{pretty_behaviour} behaviour is not available."
  end

  @impl Dialyxir.Warning
  @spec explain() :: String.t()
  def explain() do
    """
    The module using a behaviour that does not exist or is not a
    behaviour. This is also a compiler warning.

    Example:

    defmodule Example do

      @behaviour BehaviourThatDoesNotExist

      def ok() do
        :ok
      end
    end
    """
  end
end
