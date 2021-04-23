module Api


    class TagsController < ApplicationController

        def index 

            tags = Post.find(params[:post_id]).tags
            render json: {tags: tags }

        end
      
    end
    
end