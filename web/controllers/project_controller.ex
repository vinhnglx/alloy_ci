defmodule AlloyCi.ProjectController do
  use AlloyCi.Web, :controller

  alias AlloyCi.Project
  alias AlloyCi.ProjectPermission
  alias AlloyCi.Repo

  import Project, only: [repos_for: 1]

  plug EnsureAuthenticated, handler: AlloyCi.AuthController, typ: "access"

  def index(conn, _params, current_user, _claims) do
    user = current_user |> Repo.preload(:projects)
    render(conn, "index.html", projects: user.projects, current_user: current_user)
  end

  def new(conn, _params, current_user, _claims) do
    changeset = Project.changeset(%Project{})

    render(conn, "new.html",
            repos: repos_for(current_user),
            changeset: changeset,
            current_user: current_user,
            existing_ids: ProjectPermission.existing_ids
          )
  end

  def create(conn, %{"project" => project_params}, current_user, _claims) do
    case Project.create_project(project_params, current_user) do
      {:ok, project} ->
        conn
        |> put_flash(:info, "Project created successfully.")
        |> redirect(to: project_path(conn, :show, project))
      {:error, _changeset} ->
        conn
        |> put_flash(:error, "There was an error creating your project. Please try again.")
        |> redirect(to: project_path(conn, :index))
    end
  end

  def show(conn, %{"id" => id}, current_user, _claims) do
    case Project.get_by(id, current_user) do
      {:ok, project} ->
        render(conn, "show.html", project: project, current_user: current_user)
      {:error, nil} ->
        conn
        |> put_flash(:info, "Project not found")
        |> redirect(to: project_path(conn, :index))
    end
  end

  def edit(conn, %{"id" => id}, current_user, _claims) do
    case Project.get_by(id, current_user) do
      {:ok, project} ->
        changeset = Project.changeset(project)
        render(conn, "edit.html", project: project, changeset: changeset, current_user: current_user)
      {:error, nil} ->
        conn
        |> put_flash(:info, "Project not found")
        |> redirect(to: project_path(conn, :index))
    end
  end

  def update(conn, %{"id" => id, "project" => project_params}, current_user, _claims) do
    case Project.get_by(id, current_user) do
      {:ok, project} ->
        changeset = Project.changeset(project, project_params)

        case Repo.update(changeset) do
          {:ok, project} ->
            conn
            |> put_flash(:info, "Project updated successfully.")
            |> redirect(to: project_path(conn, :show, project))
          {:error, changeset} ->
            render(conn, "edit.html", project: project, changeset: changeset, current_user: current_user)
        end
      {:error, nil} ->
        conn
        |> put_flash(:info, "Project not found")
        |> redirect(to: project_path(conn, :index))
    end
  end

  def delete(conn, %{"id" => id}, current_user, _claims) do
    case Project.get_by(id, current_user) do
      {:ok, project} ->
        Repo.delete!(project)
        conn
        |> put_flash(:info, "Project deleted successfully.")
        |> redirect(to: project_path(conn, :index))
      {:error, nil} ->
        conn
        |> put_flash(:info, "Project not found")
        |> redirect(to: project_path(conn, :index))
    end
  end
end