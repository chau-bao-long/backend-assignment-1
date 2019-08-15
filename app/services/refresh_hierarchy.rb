class RefreshHierarchy
  include Base

  def perform! personnel
    clean_hierarchy
    create_hierarchy personnel
  end

  private

  def create_hierarchy personnel
    personnel.each do |key, value|
      subordinate = Staff.find_or_create_by! name: key
      superior = Staff.find_or_create_by! name: value
      Relation.create! superior: superior, subordinate: subordinate
    end
  end

  def clean_hierarchy
    Staff.destroy_all
    Relation.destroy_all
  end
end
