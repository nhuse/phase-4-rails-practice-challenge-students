class StudentsController < ApplicationController

    def index
        render json: Student.all
    end

    def show
        student = Student.find_by(id: params[:id])
        if student
            render json: student
        else
            render json: { error: "Student not found" }, status: :not_found
        end
    end

    def update
        student = Student.find_by(id: params[:id])
        if student
            student.update!(student_params)
            return render json: student, status: :accepted
        else
            return render json: student, status: :not_found
        end
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def create
        student = Student.create!(student_params)
        render json: student, status: :created
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def destroy
        student = Student.find_by(id: params[:id])
        if student
            student.destroy
            head :no_content
        else
            render json: { error: "Student not found" }, status: :not_found
        end
    end

    private

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end
end
