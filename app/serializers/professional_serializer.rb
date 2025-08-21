class ProfessionalSerializer
  def self.render_many(professionals)
    professionals.map { |professional| render(professional) }
  end

  def self.render(professional)
    {
      id: professional.id,
      specialty: professional.specialty,
      work_time_zone: professional.time_zone,
    }
  end
end
