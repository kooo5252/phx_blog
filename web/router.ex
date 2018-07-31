defmodule PhxBlog.Router do
  use PhxBlog.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhxBlog do
    pipe_through :browser # Use the default browser stack

    get     "/",                    PostsController, :index

    get     "/users",          UserController, :index
    post    "/users",                   SocialController, :create

    get     "/users/new",      UserController, :new
    post    "/users/new",      UserController, :create

    get     "/users/me",       UserController, :edit
    put     "/users/me",       UserController, :update
    post    "/users/me",       UserController, :upload_photo
    delete  "/users/me",       UserController, :delete
    get     "/users/me/post",       PostsController, :mypost

    get     "/users/:name",    UserController, :show
    get     "/users/:name/post",    PostsController, :userpost
    post    "/users/:name/social",      SocialController, :create
    delete  "/users/:name/social",      SocialController, :delete

    get     "/post",                PostsController, :new
    post    "/post",                PostsController, :create
    get     "/post/:id/edit",       PostsController, :edit
    get     "/post/:id",            PostsController, :show
    patch   "/post/:id",            PostsController, :update
    put     "/post/:id",            PostsController, :update
    delete  "/post/:id",            PostsController, :delete

    post    "/post/:id/comment",            CommentController, :create
    delete  "/post/:id/comment",            CommentController, :delete

    get     "/post/search/:query",  PostsController, :search

    get     "/login",  SessionController, :new
    post    "/login",  SessionController, :create
    delete  "/logout", SessionController, :delete
  end

#  Other scopes may use custom stacks.
  scope "/api/v1", PhxBlog do
    pipe_through :api

    get     "/users/new",      UserController, :new
    post    "/login",  SessionController, :create
    get     "/post",                PostsController, :index
    get     "/users/:id/post",      PostsController, :userpost
    post    "/post",                PostsController, :create
    patch   "/post/:id",            PostsController, :update
    delete  "/post/:id",            PostsController, :delete
    get     "/post/:id",            PostsController, :show
    post    "/post/:id/comment",    CommentController, :create
    get     "/post/search/:query",  PostsController, :search

    resources "/auth", AuthController, except: [:new, :edit]

   end
end
