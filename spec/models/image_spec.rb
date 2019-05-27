require "spec_helper"

xdescribe Spree::Image, type: :model do
  let!(:product) { create(:product, name: "spree_product") }
  let!(:variant) { create(:variant, product: product) }
  let(:spree_image) { Spree::Image.new(viewable_id: variant.id) }
  let(:image_file) { File.open(Spree::Core::Engine.root.join("spec", "fixtures", "thinking-cat.jpg")) }
  let(:text_file) { File.open(Spree::Core::Engine.root.join("spec", "fixtures", "text-file.txt")) }

  describe "mailchimp" do
    it "schedules mailchimp notification on image create" do
      if Spree.version >= "3.6.0"
        if Rails.application.config.use_paperclip
          spree_image.attachment = image_file
        else
          spree_image.attachment.attach(io: image_file, filename: "thinking-cat.jpg", content_type: "image/jpeg")
        end
      else
        spree_image.attachment = image_file
      end

      spree_image.save!

      expect(SpreeMailchimpEcommerce::UpdateProductJob).
        to have_been_enqueued.
        with(Spree::Variant.find(spree_image.viewable_id).product.id)
    end

    it "schedules mailchimp notification on image update" do
      if Spree.version >= "3.6.0"
        if Rails.application.config.use_paperclip
          spree_image.attachment = image_file
        else
          spree_image.attachment.attach(io: image_file, filename: "thinking-cat.jpg", content_type: "image/jpeg")
        end
      else
        spree_image.attachment = image_file
      end

      spree_image.save!
      spree_image.update!(attachment_file_name: "new-image.jpg")

      expect(SpreeMailchimpEcommerce::UpdateProductJob).
        to have_been_enqueued.with(
          Spree::Variant.find(spree_image.viewable_id).product.id
        ).exactly(:twice)
    end

    it "schedules mailchimp notification on image delete" do
      if Spree.version >= "3.6.0"
        if Rails.application.config.use_paperclip
          spree_image.attachment = image_file
        else
          spree_image.attachment.attach(io: image_file, filename: "thinking-cat.jpg", content_type: "image/jpeg")
        end
      else
        spree_image.attachment = image_file
      end

      spree_image.save!
      spree_image.destroy

      expect(SpreeMailchimpEcommerce::UpdateProductJob).
        to have_been_enqueued.with(
          Spree::Variant.find(spree_image.viewable_id).product.id
        ).exactly(:twice)
    end
  end
end
