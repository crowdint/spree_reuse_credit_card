module CardReuse
  def all_cards_for_user(user)
    return nil unless user

    orders = Spree::Order.where(:user_id => user.id).complete.order(:created_at).joins(:payments).where('spree_payments.source_type' => 'Spree::Creditcard').where('spree_payments.state' => 'completed')
    payments = orders.map(&:payments).flatten

    payments.map{|payment| payment.source unless payment.source.deleted?}.compact.uniq
  end
end
