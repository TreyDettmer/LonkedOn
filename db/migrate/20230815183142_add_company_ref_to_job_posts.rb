class AddCompanyRefToJobPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :job_posts, :company, index: true
  end
end
