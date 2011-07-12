class TodosController < ApplicationController
  before_filter :proxy_uid
  
  # GET /todos
  # GET /todos.xml
  def index
    @todos = @proxy.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @todos }
    end
  end

  # GET /todos/1
  # GET /todos/1.xml
  def show
    @todo = @proxy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @todo }
    end
  end

  # GET /todos/new
  # GET /todos/new.xml
  def new
    @todo = @proxy.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @todo }
    end
  end

  # GET /todos/1/edit
  def edit
    @todo = @proxy.find(params[:id])
  end

  # POST /todos
  # POST /todos.xml
  def create
    @todo = @proxy.new(params[:todo])

    respond_to do |format|
      if @todo.save
        format.html { redirect_to(todo_url(:uid => params[:uid], :id => @todo.id), :notice => 'Todo was successfully created.') }
        format.xml  { render :xml => @todo, :status => :created, :location => @todo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @todo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /todos/1
  # PUT /todos/1.xml
  def update
    @todo = @proxy.find(params[:id])

    respond_to do |format|
      if @todo.update_attributes(params[:todo])
        format.html { redirect_to(todo_url(:uid => params[:uid], :id => @todo.id), :notice => 'Todo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @todo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.xml
  def destroy
    @todo = @proxy.find(params[:id])
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to(todos_url(:uid => params[:uid])) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def proxy_uid
    @uid = params[:uid]
    @user = User.find_by_uid!(@uid)
    @proxy = @user.todos
  end
end
