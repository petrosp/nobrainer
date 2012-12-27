require 'spec_helper'

describe 'first' do
  before { load_simple_document }

  context 'when there exist some docs' do
    let!(:docs) { 5.times.map { |i| SimpleDocument.create(:field1 => i) } }

    context 'when not using a scope' do
      describe 'first' do
        it 'returns the first document' do
          SimpleDocument.first.should == docs.first
        end
      end

      describe 'last' do
        it 'returns the last document' do
          SimpleDocument.last.should == docs.last
        end
      end
    end

    context 'when using a scope' do
      describe 'first' do
        it 'returns the first document' do
          SimpleDocument.where(:field1 => 3).first.should == docs[3]
        end
      end

      describe 'last' do
        it 'returns the last document' do
          SimpleDocument.where(:field1 => 3).last.should == docs[3]
        end
      end
    end

    context 'when using an order_by scope', :pending => true do
      context 'order_by is on the id' do
        describe 'first' do
          it 'returns the document' do
            SimpleDocument.all.order_by(:id => :desc).first.should == docs.last
          end
        end

        describe 'last' do
          it 'returns the document' do
            SimpleDocument.all.order_by(:id => :desc).last.should == docs.first
          end
        end
      end

      context 'order_by is not on the id' do
        describe 'first' do
          it 'returns the document' do
            SimpleDocument.all.order_by(:field1 => :desc).first.should == docs.last
          end
        end

        describe 'last' do
          it 'returns the document' do
            SimpleDocument.all.order_by(:field1 => :desc).last.should == docs.first
          end
        end
      end
    end
  end

  context 'when there are no docs' do
    describe 'first' do
      it 'returns nil' do
        SimpleDocument.first.should == nil
      end
    end

    describe 'last' do
      it 'returns nil' do
        SimpleDocument.last.should == nil
      end
    end
  end
end
