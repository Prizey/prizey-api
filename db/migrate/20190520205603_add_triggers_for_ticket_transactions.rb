# frozen_string_literal: true

class AddTriggersForTicketTransactions < ActiveRecord::Migration[5.2]
  def up
    execute create_update_function
    execute create_trigger
  end

  def down
    execute 'DROP TRIGGER IF EXISTS update_user_balance ON ticket_transactions'
    execute 'DROP FUNCTION IF EXISTS updating_ticket_transactions'
  end

  private

  def create_update_function
    <<-SQL
      CREATE OR REPLACE FUNCTION updating_ticket_transactions() RETURNS trigger AS
      $BODY$
      BEGIN
        IF (TG_OP = 'DELETE') THEN
          UPDATE users
          SET balance = (
            SELECT SUM(amount) FROM ticket_transactions
            WHERE user_id = OLD.user_id
          )
          WHERE id = OLD.user_id;
        ELSIF (TG_OP = 'UPDATE' OR TG_OP = 'INSERT') THEN
          UPDATE users
          SET balance = (
            SELECT SUM(amount) FROM ticket_transactions
            WHERE user_id = NEW.user_id
          )
          WHERE id = NEW.user_id;
        END IF;

        RETURN NULL;
      END;
      $BODY$
      language plpgsql;
    SQL
  end

  def create_trigger
    <<-SQL
      CREATE TRIGGER update_user_balance AFTER INSERT OR UPDATE OR DELETE
        ON ticket_transactions FOR EACH ROW EXECUTE PROCEDURE updating_ticket_transactions();
    SQL
  end
end
