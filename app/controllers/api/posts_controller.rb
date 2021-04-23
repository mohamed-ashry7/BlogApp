module Api


    class PostsController < ApplicationController
        before_action :authorized 
        before_action :same_user ,only: [:update,:destroy]
        def index
            @posts = Post.order('created_at DESC');
            render json: {status: "SUCCESS", data: @posts},status: :ok
        end


        def create 
            if params[:tags] && params[:tags].length ==0 || params[:tags]==nil
                render json: {status: "ERROR", message: "Please enter at least one tag" }
            else 
                
                @post = Post.create(post_params)
                @post.user_id= @user.id
                if @post.save 
                    render json: {status: "SUCCESS", data: @post},status: :ok
                    tags = params[:tags].uniq
                    tags.each do |tag|
                        @post.tags.create(tag: tag) 
                    end
                    PostRemoveWorker.perform_at(24.hours.from_now,@post.id)

                else 
                    render json: {status: "ERROR",data: @post.errors},status: :unprocessable_entity
                end
            end 
        end


        def destroy
            @post = Post.find(params[:id])
            @post.destroy
            render json: {status: "SUCCESS", message: "POST_DELETED", data: @post},status: :ok

        end

        def update
            @post = Post.find(params[:id])
            if params[:tags] && params[:tags].length >0
                @post.tags.each do |tag|
                    tag.destroy
                end
                params[:tags].each do |tag|
                    @post.tags.create(tag: tag) 
                end
            elsif params[:tags] && params[:tags].length ==0
                render json: {status: "ERROR", message: "Please enter at least one tag" }
            end

            if @post.update(post_params)
                render json: {status: "SUCCESS", message: "POST_UPDATED", data: @post},status: :ok
            else 
                render json: {status: "ERROR", message: "Could update the post", data: @post.error},status: :unprocessable_entity
            end
        end

        def get_id
            Post.find(params[:id]).user_id
        end

        def same_user
            render json: { message: 'You are not authorized' }, status: :unauthorized unless @user.id == get_id
        end

        private 
        def post_params 
                params.permit(:title,:body)
        end


    end
    
end