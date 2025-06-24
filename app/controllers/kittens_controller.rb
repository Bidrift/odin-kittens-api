class KittensController < ApplicationController
    def index
        @kittens = Kitten.all
    end

    def show
        @kitten = Kitten.find(params[:id])
    end

    def new
        @kitten = Kitten.new
    end

    def create
        @kitten = Kitten.new(kitten_params)
        if @kitten.save
            flash['notice'] = "A new kitten has been created."
            redirect_to kitten_path
        else
            flash.now['alert'] = "Something has prevented the creation of this kitten."
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        @kitten = Kitten.find(params[:id])
        if @kitten.destroy
            flash['notice'] = "A kitten has been deleted."
            redirect_to kittens_path
        else
            flash.now['alert'] = "Something has prevented this kitten from being deleted."
            head(:unprocessable_entity)
        end
    end

    def edit
        @kitten = Kitten.find(params[:id])
    end

    def update
        @kitten = Kitten.find(params[:id])
        if @kitten.update(kitten_params)
            flash['notice'] = "Kitten attributes have been updated"
            redirect_to kitten_path
        else
            flash.now['alert'] = "Something has prevented the edit of this kitten."
            render :edit, status: :unprocessable_entity
        end
    end

    private

        def kitten_params
            params.expect(kitten: [:name, :age, :softness, :cuteness])
        end
end
