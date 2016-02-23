require 'spec_helper'

# TODO: Support NOT NULL
describe PerconaMigrator::Lhm::Fake::Adapter do
  let(:migration) { double(:migration) }
  let(:table_name) { :comments }

  let(:adapter) { described_class.new(migration, table_name) }

  describe '#add_column' do
    before do
      allow(migration).to(
        receive(:add_column).with(table_name, column_name, type, options)
      )
    end

    before { adapter.add_column(column_name, definition) }

    context 'with :integer' do
      let(:definition) { 'INT(11) DEFAULT NULL' }
      let(:column_name) { :some_id_field }
      let(:type) { :integer }
      # Add WithLimit and WithDefault contexts
      let(:options) { { limit: 4, default: nil, null: true } }

      it 'calls #add_column in the migration' do
        expect(migration).to(
          have_received(:add_column)
          .with(table_name, column_name, type, options)
        )
      end
    end

    context 'with :string' do
      let(:definition) { 'VARCHAR(255)' }
      let(:column_name) { :body }
      let(:type) { :string }
      let(:options) { { limit: 255, default: nil, null: true } }

      it 'calls #add_column in the migration' do
        expect(migration).to(
          have_received(:add_column)
          .with(table_name, column_name, type, options)
        )
      end

      context 'when a default value is specified' do
        let(:definition) { "VARCHAR(255) DEFAULT 'foo'" }
        let(:options) { { limit: 255, default: 'foo', null: true } }

        it 'calls #add_column in the migration' do
          expect(migration).to(
            have_received(:add_column)
            .with(table_name, column_name, type, options)
          )
        end
      end
    end

    context 'with :date' do
      let(:definition) { 'DATE DEFAULT NULL' }
      let(:column_name) { :due_on }
      let(:type) { :date }
      let(:options) { { limit: nil, default: nil, null: true } }

      it 'calls #add_column in the migration' do
        expect(migration).to(
          have_received(:add_column)
          .with(table_name, column_name, type, options)
        )
      end
    end

    context 'with :datetime' do
      let(:definition) { 'DATETIME' }
      let(:column_name) { :created_at }
      let(:type) { :datetime }
      let(:options) { { limit: nil, default: nil, null: true } }

      it 'calls #add_column in the migration' do
        expect(migration).to(
          have_received(:add_column)
          .with(table_name, column_name, type, options)
        )
      end
    end

    context 'with :boolean' do
      let(:column_name) { :deleted }
      let(:type) { :boolean }

      context 'when specifying BOOLEAN' do
        context 'with NOT NULL' do
          let(:definition) { 'BOOLEAN NOT NULL DEFAULT FALSE' }
          let(:options) { { limit: nil, default: false, null: false } }

          it 'calls #add_column in the migration' do
            expect(migration).to(
              have_received(:add_column)
              .with(table_name, column_name, type, options)
            )
          end
        end

        context 'with NULL' do
          let(:definition) { 'BOOLEAN NULL DEFAULT FALSE' }
          let(:options) { { limit: nil, default: false, null: true } }

          it 'calls #add_column in the migration' do
            expect(migration).to(
              have_received(:add_column)
              .with(table_name, column_name, type, options)
            )
          end
        end
      end

      context 'when specifying TINYINT' do
        context 'with DEFAULT 0' do
          let(:definition) { 'TINYINT(1) default 0' }
          let(:options) { { limit: 1, default: false, null: true } }

          it 'calls #add_column in the migration' do
            expect(migration).to(
              have_received(:add_column)
              .with(table_name, column_name, type, options)
            )
          end
        end

        context 'with DEFAULT 1' do
          let(:definition) { 'TINYINT(1) default 1' }
          let(:options) { { limit: 1, default: true, null: true } }

          it 'calls #add_column in the migration' do
            expect(migration).to(
              have_received(:add_column)
              .with(table_name, column_name, type, options)
            )
          end
        end
      end
    end
  end
end
