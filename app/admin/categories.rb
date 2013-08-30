ActiveAdmin.register Category do
  controller do
    def permitted_params
      if ["create", "update"].include? params[:action]
        return { category: params.require(:category).permit(:name) }
      else
        return params
      end
    end
  end
end
