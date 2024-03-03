class LearningResourceSerializer
    include JSONAPI::Serializer

    set_type "learning_resource"
    attributes :country, :video, :images
end