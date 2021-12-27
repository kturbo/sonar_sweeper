RSpec.shared_examples "sonar sweeper" do
  let(:sweeper) { described_class.new(depth_report) }
  let(:depth_report) { [] }

  context "when depth report passed" do
    context "and is not an array" do
      let(:depth_report) { "a" }

      it "complains with proper error" do
        expect { described_class.new("a") }.to raise_error(TypeError)
      end
    end

    context "and depth report empty" do
      it "returns empty aggregated report" do
        expect(sweeper.aggregated_report).to match_array([])
      end

      it "returns zero increases for depth report" do
        expect(sweeper.direct_increases_count).to eq(0)
      end

      it "returns zero increases for aggregated report" do
        expect(sweeper.aggregated_increases_count).to eq(0)
      end
    end

    context "and depth report not empty" do
      describe "#aggregated_report is properly returned" do
        let(:subject) { sweeper.aggregated_report }
        let(:depth_report) { [5, 4, 8, 2, 1] }

        it { is_expected.to eq [17, 14, 11] }

        context "when not enough measures in the depth report" do
          let(:depth_report) { [1, 2] }

          it { is_expected.to eq [] }
        end

        context "when all measures in report are the same" do
          let(:depth_report) { [3, 3, 3, 3] }

          it { is_expected.to eq [9, 9] }
        end

        context "when test case from the task inserted" do
          let(:depth_report) { [199, 200, 208, 210, 200, 207, 240, 269, 260, 263] }

          it { is_expected.to eq [607, 618, 618, 617, 647, 716, 769, 792] }
        end
      end

      describe ".increases_count returns proper result" do
        let(:subject) { described_class.increases_count(report) }

        context "when all measures in report are the same" do
          let(:report) { [3, 3, 3, 3] }

          it { is_expected.to eq 0 }
        end

        context "when measures are constantly increasing" do
          let(:report) { [1, 2, 3, 4, 5, 6] }

          it { is_expected.to eq 5 }
        end

        context "when measures are constantly idecreasing" do
          let(:report) { [5, 4, 3, 2, 1] }

          it { is_expected.to eq 0 }
        end

        context "when measures are generally increasing" do
          let(:report) { [1, 2, 3, 1, 5, 6] }

          it { is_expected.to eq 4 }
        end

        context "when measures are generrally idecreasing" do
          let(:report) { [5, 4, 8, 2, 1] }

          it { is_expected.to eq 1 }
        end

        context "when actual report from the task inserted" do
          let(:report) { [199, 200, 208, 210, 200, 207, 240, 269, 260, 263] }

          it { is_expected.to eq 7 }
        end

        context "when aggregated report from the task inserted" do
          let(:report) { [607, 618, 618, 617, 647, 716, 769, 792] }

          it { is_expected.to eq 5 }
        end
      end
    end
  end
end
