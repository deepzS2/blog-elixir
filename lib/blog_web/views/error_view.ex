defmodule BlogWeb.ErrorView do
  use BlogWeb, :view

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  def render("401.json", _assigns) do
    %{message: "You need to be authenticated to access this route"}
  end

  def render("unauthorized.json", %{route: route}) do
    %{message: "You are not the owner of the #{route}!"}
  end
end
