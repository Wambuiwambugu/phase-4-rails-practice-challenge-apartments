class LeasesController < ApplicationController
    def create
        lease = Lease.create(lease_params)
        if lease.valid?
            render json: lease, status: :ok
        else
            render json: {error: lease.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def destroy
        lease = Lease.find_by(id: params[:id])
        if lease
            lease.destroy
            head :no_content
        else
            render_not_found
        end
    end

    private

    def render_not_found
        render json: {error: "Lease not found"}, status: :not_found
    end

    def lease_params
        params.permit(:rent, :apartment_id, :tenant_id)
    end
end
