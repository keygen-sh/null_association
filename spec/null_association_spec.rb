# frozen_string_literal: true

require 'spec_helper'

RSpec.describe NullAssociation do
  describe '.belongs_to' do
    temporary_table :tmp_accounts do |t|
      t.references :tmp_plan
      t.string :name
    end

    temporary_table :tmp_plans do |t|
      t.string :name
    end

    temporary_model :tmp_plan
    temporary_model :tmp_null_plan, table_name: nil, base_class: nil

    context 'with a class' do
      temporary_model :tmp_account do
        belongs_to :tmp_plan, optional: true, null_object: TmpNullPlan
      end

      it 'should return a null object for a nil association' do
        instance = TmpAccount.new(tmp_plan: nil)

        expect(instance.tmp_plan).to be_a TmpNullPlan
      end

      it 'should not return a null object for a present association' do
        instance = TmpAccount.new(tmp_plan: TmpPlan.new)

        expect(instance.tmp_plan).to be_a TmpPlan
      end
    end

    context 'with a string' do
      temporary_model :tmp_account do
        belongs_to :tmp_plan, optional: true, null_object: 'TmpNullPlan'
      end

      it 'should return a null object for a nil association' do
        instance = TmpAccount.new(tmp_plan: nil)

        expect(instance.tmp_plan).to be_a TmpNullPlan
      end

      it 'should not return a null object for a present association' do
        instance = TmpAccount.new(tmp_plan: TmpPlan.new)

        expect(instance.tmp_plan).to be_a TmpPlan
      end
    end

    context 'with a singleton' do
      temporary_model :tmp_null_plan_singleton, table_name: nil, base_class: nil do
        include Singleton
      end

      temporary_model :tmp_account do
        belongs_to :tmp_plan, optional: true, null_object: TmpNullPlanSingleton.instance
      end

      it 'should return a null object singleton for a nil association' do
        instance = TmpAccount.new(tmp_plan: nil)

        expect(instance.tmp_plan).to eq TmpNullPlanSingleton.instance
      end

      it 'should not return a null object for a present association' do
        instance = TmpAccount.new(tmp_plan: tmp_plan = TmpPlan.new)

        expect(instance.tmp_plan).to eq tmp_plan
      end
    end

    context 'with an instance' do
      let(:tmp_null_plan) { TmpNullPlan.new }

      temporary_model :tmp_account do |context|
        belongs_to :tmp_plan, optional: true, null_object: context.tmp_null_plan
      end

      it 'should return a null object instance for a nil association' do
        instance = TmpAccount.new(tmp_plan: nil)

        expect(instance.tmp_plan).to eq tmp_null_plan
      end

      it 'should not return a null object for a present association' do
        instance = TmpAccount.new(tmp_plan: tmp_plan = TmpPlan.new)

        expect(instance.tmp_plan).to eq tmp_plan
      end
    end

    context 'without :optional' do
      temporary_model :tmp_account

      it 'should raise' do
        expect { TmpAccount.belongs_to :tmp_plan, optional: false, null_object: TmpNullPlan }
          .to raise_error ArgumentError
      end
    end

    context 'with :required' do
      temporary_model :tmp_account

      it 'should raise' do
        expect { TmpAccount.belongs_to :tmp_plan, required: true, null_object: TmpNullPlan }
          .to raise_error ArgumentError
      end
    end
  end

  describe '.has_one' do
    temporary_table :tmp_accounts do |t|
      t.string :name
    end

    temporary_table :tmp_billings do |t|
      t.references :tmp_account
      t.string :name
    end

    temporary_model :tmp_billing
    temporary_model :tmp_null_billing, table_name: nil, base_class: nil

    context 'with a class' do
      temporary_model :tmp_account do
        has_one :tmp_billing, null_object: TmpNullBilling
      end

      it 'should return a null object for a nil association' do
        instance = TmpAccount.new(tmp_billing: nil)

        expect(instance.tmp_billing).to be_a TmpNullBilling
      end

      it 'should not return a null object for a present association' do
        instance = TmpAccount.new(tmp_billing: TmpBilling.new)

        expect(instance.tmp_billing).to be_a TmpBilling
      end
    end

    context 'with a string' do
      temporary_model :tmp_account do
        has_one :tmp_billing, null_object: 'TmpNullBilling'
      end

      it 'should return a null object for a nil association' do
        instance = TmpAccount.new(tmp_billing: nil)

        expect(instance.tmp_billing).to be_a TmpNullBilling
      end

      it 'should not return a null object for a present association' do
        instance = TmpAccount.new(tmp_billing: TmpBilling.new)

        expect(instance.tmp_billing).to be_a TmpBilling
      end
    end

    context 'with a singleton' do
      temporary_model :tmp_null_billing_singleton, table_name: nil, base_class: nil do
        include Singleton
      end

      temporary_model :tmp_account do
        has_one :tmp_billing, null_object: TmpNullBillingSingleton.instance
      end

      it 'should return a null object singleton for a nil association' do
        instance = TmpAccount.new(tmp_billing: nil)

        expect(instance.tmp_billing).to eq TmpNullBillingSingleton.instance
      end

      it 'should not return a null object for a present association' do
        instance = TmpAccount.new(tmp_billing: tmp_billing = TmpBilling.new)

        expect(instance.tmp_billing).to eq tmp_billing
      end
    end

    context 'with an instance' do
      let(:tmp_null_billing) { TmpNullBilling.new }

      temporary_model :tmp_account do |context|
        has_one :tmp_billing, null_object: context.tmp_null_billing
      end

      it 'should return a null object instance for a nil association' do
        instance = TmpAccount.new(tmp_billing: nil)

        expect(instance.tmp_billing).to eq tmp_null_billing
      end

      it 'should not return a null object for a present association' do
        instance = TmpAccount.new(tmp_billing: tmp_billing = TmpBilling.new)

        expect(instance.tmp_billing).to eq tmp_billing
      end
    end
  end
end
