class TenantsController < ApplicationController

    def index
        tenants = Tenant.all
        render json: tenants, status: :ok
    end

    def show
        tenant = find_by_id
        if tenant
            render json: tenant, status: :ok
        else
            render_not_found
        end
    end

    def create
        tenant = Tenant.create(tenant_params)
        if tenant.valid?
            render json: tenant, status: :ok
        else
            render json: {error: tenant.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def update
        tenant = find_by_id
        if tenant
            tenant.update(tenant_params)
            if tenant.valid?
                render json: tenant, status: :ok
            else
                render json: {error: tenant.errors.full_messages}, status: :unprocessable_entity
            end
        else
            render_not_found
        end
    end

    def destroy
        tenant = find_by_id
        if tenant
            tenant.destroy
            head :no_content
        else
            render_not_found
        end
    end

    private

    def tenant_params
        params.permit(:name, :age)
    end

    def render_not_found
        render json: {error: "Tenant not found"}, status: :not_found
    end

    def find_by_id
        Tenant.find_by(id: params[:id])
    end
end


