class GetAllSuperiors
  include Base

  def perform! name
    Staff.where("id IN (#{direct_superiors_of(name)} UNION #{indirect_superiors_of(name)})")
  end

  private 

  def direct_superiors_of name
    Staff.joins(:superiors).where(name: name).select(:superior_id).to_sql
  end

  def indirect_superiors_of name
    <<~SQL
        SELECT B.superior_id FROM (#{direct_superiors_of(name)}) AS A 
        LEFT JOIN relations AS B 
        ON A.superior_id = B.subordinate_id
    SQL
  end
end
