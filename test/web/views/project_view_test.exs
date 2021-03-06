defmodule AlloyCi.Web.ProjectViewTest do
  @moduledoc """
  """
  use AlloyCi.Web.ConnCase, async: true
  import AlloyCi.Web.ProjectView
  import AlloyCi.Factory

  test "user with GitHub auth validates" do
    user = (:user |> build() |> with_authentication(provider: "github")).user

    assert has_github_auth(user)
  end

  test "user without GitHub auth validates" do
    user = (:user |> build() |> with_authentication()).user

    refute has_github_auth(user)
  end
end
