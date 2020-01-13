module DailyUpdate
  module Operation
    class Update < Trailblazer::Operation
      step :set_period_to_update
      pass :log_update_period
      step Nested INSEE::Operation::FetchUpdates
      step Nested Task::AdaptApiResults
      step Nested Task::Supersede

      def set_period_to_update(ctx, **)
        ctx[:from] = Time.now.beginning_of_month
        ctx[:to]   = Time.zone.now
      end

      def log_update_period(_, from:, to:, logger:, **)
        logger.info "Importing from #{from} to #{to}"
      end
    end
  end
end
