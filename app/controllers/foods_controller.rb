class FoodsController < ApplicationController

  def index
    @foods = Unirest.get("http://localhost:3000/api/v2/foods").body
    render "index.html.erb"
  end

  def show
    @food = Unirest.get("http://localhost:3000/api/v2/foods/#{params[:id]}").body
    render "show.html.erb"   
  end

  def new
    render "new.html.erb"
  end

  def create
    food = Unirest.post("http://localhost:3000/api/v2/foods",
                        headers:{"Accept" => "application/json"},
                        parameters:{ingredient1: params[:ingredient1],
                                    ingredient2: params[:ingredient2],
                                    spice1: params[:spice1],
                                    spice2: params[:spice2]}
                        ).body
    redirect_to "/foods/#{food['id']}"
  end

  def edit
    @food = Unirest.get("http://localhost:3000/api/v2/foods/#{params[:id]}").body
    render "edit.html.erb"
  end

  def update
    food = Unirest.patch("http://localhost:3000/api/v2/foods/#{params[:id]}",
                          headers:{"Accept" => "application/json" },
                          parameters:{ingredient1: params[:ingredient1],
                                    ingredient2: params[:ingredient2],
                                    spice1: params[:spice1],
                                    spice2: params[:spice2]}
                          ).body 
    redirect_to "/foods/#{food['id']}"  
  end

  def destroy
    Unirest.delete("http://localhost:3000/api/v2/foods/#{params[:id]}", 
                    headers:{"Accept" => "application/json"}
                  ).body
    redirect_to "/foods"
  end


end
