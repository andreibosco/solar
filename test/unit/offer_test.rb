require 'test_helper'

class  OfferTest < ActiveSupport::TestCase

  fixtures :courses, :curriculum_units

  test "deve pertencer a um curso" do
  	offer = Offer.create(:course => nil)

  	assert offer.invalid?
  	assert_equal offer.errors[:course].first, I18n.t(:blank, :scope => [:activerecord, :errors, :messages])
	end

	test "deve pertencer a uma unidade curricular" do
		offer = Offer.create(:curriculum_unit => nil)

  	assert offer.invalid?
  	assert_equal offer.errors[:curriculum_unit].first, I18n.t(:blank, :scope => [:activerecord, :errors, :messages])
	end

	test "deve ter um semestre" do
		offer = Offer.create(:semester => nil)

		assert offer.invalid?
  	assert_equal offer.errors[:semester].first, I18n.t(:blank, :scope => [:activerecord, :errors, :messages])
	end

	test "semestre deve possuir formato especificado" do
		offer = Offer.create(:semester => "abcd")

		assert offer.invalid?
  	assert_equal offer.errors[:semester].first, I18n.t(:invalid, :scope => [:activerecord, :errors, :messages])

  	offer = Offer.create(:semester => "20121")

		assert offer.invalid?
  	assert_equal offer.errors[:semester].first, I18n.t(:invalid, :scope => [:activerecord, :errors, :messages])
	end

	test "deve ter data de inicio" do
		offer = Offer.create(:start_date => nil)

		assert offer.invalid?
  	assert_equal offer.errors[:start_date].first, I18n.t(:blank, :scope => [:activerecord, :errors, :messages])
	end

	test "deve ter data de fim" do
		offer = Offer.create(:end_date => nil)

		assert offer.invalid?
  	assert_equal offer.errors[:end_date].first, I18n.t(:blank, :scope => [:activerecord, :errors, :messages])
	end

	test "semestre deve ser unico para uma mesma unidade curricular e um mesmo curso" do
		offer1 = create()
  	offer2 = create()

		assert offer1.valid? 
		assert offer2.invalid? 
		
  	assert_equal offer2.errors[:semester].first, I18n.t(:existing_semester, :scope => [:offers])
	end

	test "data de inicio deve ser menor que a data final" do
		offer = create(:start_date => "2012-12-01", :end_date => "2012-11-30")

		assert offer.invalid? 
  	assert_equal offer.errors[:start_date].first, I18n.t(:range_date_error, :scope => [:offers])
	end

  private
    def create(options={})
      Offer.create({
        :semester => "1900.2", 
        :start_date => "2012-12-01", 
        :end_date => "2012-12-31", 
        :course => courses(:c2), 
        :curriculum_unit => curriculum_units(:r5)
        }.merge(options))
    end

end