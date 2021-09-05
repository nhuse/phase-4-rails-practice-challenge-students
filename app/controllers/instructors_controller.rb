class InstructorsController < ApplicationController

    def index
        render json: Instructor.all
    end

    def show
    instructor = Instructor.find_by(id: params[:id])
        if instructor
            render json: instructor
        else
            render json: { error: "Instructor not found" }, status: :not_found
        end
    end

    def update
        instructor = Instructor.find_by(id: params[:id])
        if instructor
            instructor.update!(instructor_params)
            return render json: instructor, status: :accepted
        else
            return render json: instructor, status: :not_found
        end
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def destroy
        instructor = Instructor.find_by(id: params[:id])
        if instructor
            instructor.destroy
            head :no_content
        else
            render json: { error: "Instructor not found" }, status: :not_found
        end
    end

    private

    def instructor_params
        params.permit(:name)
    end
end