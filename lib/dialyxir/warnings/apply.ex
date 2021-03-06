defmodule Dialyxir.Warnings.Apply do
  @behaviour Dialyxir.Warning

  @impl Dialyxir.Warning
  @spec warning() :: :apply
  def warning(), do: :apply

  @impl Dialyxir.Warning
  @spec format_short([String.t()]) :: String.t()
  def format_short(_) do
    "Function application will not succeed."
  end

  @impl Dialyxir.Warning
  @spec format_long([String.t()]) :: String.t()
  def format_long([args, arg_positions, fail_reason, signature_args, signature_return, contract]) do
    pretty_args = Dialyxir.PrettyPrint.pretty_print_args(args)

    call_string =
      Dialyxir.WarningHelpers.call_or_apply_to_string(
        arg_positions,
        fail_reason,
        signature_args,
        signature_return,
        contract
      )

    "Function application with arguments #{pretty_args} #{call_string}"
  end

  @impl Dialyxir.Warning
  @spec explain() :: String.t()
  def explain() do
    """
    The function being invoked exists, and has the correct arity, but
    will not succeed.

    Example:

    defmodule Example do
      def ok() do
        fun = fn :ok -> :ok end
        fun.(:error)
      end
    end
    """
  end
end
