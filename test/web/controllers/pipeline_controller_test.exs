defmodule AlloyCi.Web.PipelineControllerTest do
  @moduledoc """
  """
  use AlloyCi.Web.ConnCase
  alias AlloyCi.Pipelines
  import AlloyCi.Factory

  setup do
    project = insert(:project)
    pipeline = insert(:clean_pipeline, project: project)
    user = insert(:user)
    insert(:clean_project_permission, project: project, user: user)

    {:ok, %{project: project, pipeline: pipeline, user: user}}
  end

  test "it duplicates the current pipeline", %{project: project, pipeline: pipeline, user: user} do
    conn =
      user
      |> guardian_login(:access)
      |> post("/projects/#{project.id}/pipelines/", %{id: pipeline.id})

    assert conn.status == 302
  end

  test "it cancels the pipeline", %{project: project, pipeline: pipeline, user: user} do
    conn =
      user
      |> guardian_login(:access)
      |> delete("/projects/#{project.id}/pipelines/#{pipeline.id}")

    assert conn.status == 302
    pipeline = Pipelines.get(pipeline.id)
    assert pipeline.status == "cancelled"
  end

  test "it shows chosen pipeline", %{project: project, pipeline: pipeline, user: user} do
    conn =
      user
      |> guardian_login(:access)
      |> get("/projects/#{project.id}/pipelines/#{pipeline.id}")

    assert html_response(conn, 200) =~ "#{pipeline.commit["message"]}"
  end

  test "it redirects if user cannot access pipeline", %{project: project, pipeline: pipeline} do
    conn =
      :user
      |> insert()
      |> guardian_login(:access)
      |> get("/projects/#{project.id}/pipelines/#{pipeline.id}")

    assert html_response(conn, 302) =~ "redirected"
  end
end
