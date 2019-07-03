class Stock
  module Operation
    class Import < Trailblazer::Operation
      step :uri
      step :model
      step Nested Files::Operation::Download
      step Nested Files::Operation::Extract
      step :csv
      step Nested Stock::Task::ImportCSV

      step :delete_tmp_files
      fail :delete_tmp_files

      def uri(ctx, stock:, **)
        ctx[:uri] = stock.uri
      end

      def model(ctx, stock:, **)
        ctx[:model] = stock.class::RELATED_MODEL
      end

      def csv(ctx, extracted_file:, **)
        ctx[:csv] = extracted_file
      end

      def delete_tmp_files(_, extracted_file:, **)
        FileUtils.rm_rf extracted_file
      end
    end
  end
end
