class PrototypesController < ApplicationController
    before_action :set_prototype, only:['show', 'update', 'edit','destroy' ]
    before_action :authenticate_user!, only:['create', 'edit', 'destroy']

    def index
        @prototypes = Prototype.includes(:user)
    end

    def new
        @prototype = Prototype.new
        @comments = @prototype.comments.includes(:user)
    end

    def create
        @prototype = Prototype.create(prototype_params)
       if @prototype.save
        redirect_to action: :index
       else
        redirect_to action: :new
    end
    unless user_signed_in?
        redirect_to action: :index
      end
    end

    def show
        @comment = Comment.new
        @comments = @prototype.comments.includes(:user)
    end

    def edit
        unless user_signed_in?
            redirect_to action: :index
          end
    end

    def update
        if @prototype.update(prototype_params)
            redirect_to action: :index
        else
            render 'edit'
      end
    end

    def destroy
            @prototype.destroy
            redirect_to root_path
            unless user_signed_in?
                redirect_to action: :index
              end
    end
    private

    def set_prototype
        @prototype = Prototype.find(params[:id])
    end

    def prototype_params
        params.require(:prototype).permit(:title,:catch_copy,:concept,:image).merge(user_id: current_user.id)
      
    end
end
