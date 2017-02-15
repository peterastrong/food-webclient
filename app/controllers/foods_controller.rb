class FoodsController < ApplicationController
  
  def index
    @foods = Food.all 
    render "index.html.erb"
  end

  def show
    @food = Food.find_by(id: params[:id])
    render "show.html.erb"   
  end

  def new
    render "new.html.erb"
  end

  def create
    @food = Food.create(ingredient1: params[:ingredient1],
                                    ingredient2: params[:ingredient2],
                                    spice1: params[:spice1],
                                    spice2: params[:spice2])
    redirect_to "/foods/#{@food.id}"
  end

  def edit
    @food = Food.find_by(id: params[:id])
    render :edit # same as "edit.html.erb"
  end

  def update
    @food = Food.find_by(id: params[:id])
    @food.update(ingredient1: params[:ingredient1], ingredient2: params[:ingredient2], spice1: params[:spice1], spice2: params[:spice2])
    redirect_to "/foods/#{@food.id}"  
  end

  def destroy
    food = Food.find_by(id: params[:id])
    food.destroy
    redirect_to "/foods"
  end


end
