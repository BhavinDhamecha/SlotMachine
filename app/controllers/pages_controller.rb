class PagesController < ApplicationController
  def home
    @credit = session[:user_details].present? ? ( session[:user_details]['user_id'] == current_user.id ? session[:user_details]['credit'] : 10 ) : 10

    session[:user_details] = { user_id: current_user.id, credit: @credit }
  end

  def run_machine
    credit = session[:user_details]['credit']
    render json: { credit: credit, message: "You're out of the credit" } and return if credit <= 0

    credit -= 1
    slot1 = SYMBOLS.sample
    slot2 = SYMBOLS.sample
    slot3 = SYMBOLS.sample
    new_credit = shamble_slot(slot1, slot2, slot3, credit)
    session[:user_details]['credit'] = new_credit
    render json: { credit: new_credit, slot1: slot1, slot2: slot2, slot3: slot3 }
  end

  def cash_out
    current_user.update(credits: session[:user_details]['credit'])
  end

  private

  SYMBOLS = %i[C L O W]

  def shamble_slot(s1, s2, s3, credit)
    if s1 == s2 and s2 == s3
      new_credit = add_new_credit(s1, credit)
    else
      new_credit = credit
    end

    new_credit
  end

  def add_new_credit(slot, credit)
    case slot
    when :C
      credit = credit + 10
    when :L
      credit = credit + 20
    when :O
      credit = credit + 30
    when :W
      credit = credit + 40
    end

    credit
  end
end
