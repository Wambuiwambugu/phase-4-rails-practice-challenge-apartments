class ApartmentsController < ApplicationController

    def index
        apartments = Apartment.all
        render json: apartments, status: :ok
    end

    def show
        apartment = find_by_id
        if apartment
            render json: apartment, status: :ok
        else
            render_not_found
        end
    end

    def create
        apartment = Apartment.create(apartment_params)
        if apartment.valid?
            render json: apartment, status: :ok
        else
            render json: {error: apartment.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def update
        apartment = find_by_id
        if apartment
            apartment.update(apartment_params)
            if apartment.valid?
                render json: apartment, status: :ok
            else
                render json: {error: apartment.errors.full_messages}, status: :unprocessable_entity
            end
        else
            render_not_found
        end
    end

    def destroy
        apartment = find_by_id
        if apartment
            apartment.destroy
            head :no_content
        else
            render_not_found
        end
    end

    private

    def apartment_params
        params.permit(:number)
    end

    def render_not_found
        render json: {error: "Apartment not found"}, status: :not_found
    end

    def find_by_id
        Apartment.find_by(id: params[:id])
    end
end
