describe Fastlane::Actions::GetLastCircleciBuildNumberAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The get_last_circleci_build_number plugin is working!")

      Fastlane::Actions::GetLastCircleciBuildNumberAction.run(nil)
    end
  end
end
