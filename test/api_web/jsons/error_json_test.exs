defmodule ApiWeb.ErrorJSONTest do
  use ApiWeb.ConnCase, async: true

  alias ApiWeb.ErrorJSON

  test "renders 500" do
    assert %{errors: errors} = ErrorJSON.render("500.json", %{})

    assert errors == %{detail: "Internal Server Error"}
  end
end
