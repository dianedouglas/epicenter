class AttendanceRecordAmendment
  include ActiveModel::Model

  validates :student_id, :date, :status, presence: true

  attr_accessor :student_id, :date, :status

  def initialize(attributes={})
    @student_id = attributes[:student_id]
    @date = attributes[:date] unless attributes[:date].blank?
    @status = attributes[:status]
  end

  def save
    if valid?
      amend_attendance_record
    else
      false
    end
  end

private

  def amend_attendance_record
    case status
    when "On time"
      attendance_record.update(tardy: false)
    when "Tardy"
      attendance_record.update(tardy: true)
    when "Absent"
      attendance_record.try(:destroy)
    end
  end

  def attendance_record
    @attendance_record ||= AttendanceRecord.find_or_initialize_by(student_id: student_id, date: date)
  end
end
