module BootstrapHelper
  def bootstrap_class_for(flash_type)
    {
      success: "alert-success",
      error: "alert-danger",
      alert: "alert-warning",
      notice: "alert-p"
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end
end
