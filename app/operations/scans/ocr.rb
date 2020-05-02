# frozen_string_literal: true

class Scan::Ocr < BaseOperation
  step :image_to_base64
  step :recognize_text
  step :save_data

  def find_image
    scan = Scan.find_by_id(params[:id])

    error!(:scan, t('errors.not_found')) unless scan

    image_base64 = Base64.strict_encode64(scan.image_url)
    update_context(:image_base64, image_base64)
    update_context(:scan, scan)
  end

  def recognize_text
    response = VisionClient.call(image_base64: context[:image_base64])

    update_context(:data, response)
  end

  def save_data
    # :status => "initialized",
    # :quotation_id => nil,
    #     :language => nil,
    #         :text => nil,
    #          :log => nil,
    context[:scan]
  end
end
