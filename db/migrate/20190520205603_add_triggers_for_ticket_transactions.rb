# frozen_string_literal: true

class AddTriggersForTicketTransactions < ActiveRecord::Migration[5.2]
  def up
    execute create_update_function
    execute create_delete_function
    execute create_trigger
  end

  def down
    execute 'DROP TRIGGER IF EXISTS creating_tickets ON ticket_transactions'
    execute 'DROP TRIGGER IF EXISTS deleting_tickets ON ticket_transactions'
    execute 'DROP FUNCTION IF EXISTS update_after_create_tickets'
    execute 'DROP FUNCTION IF EXISTS update_after_delete_tickets'
  end

  private

  def create_update_function
    <<-SQL
      CREATE OR REPLACE FUNCTION update_after_create_tickets() RETURNS trigger AS
      $BODY$
      BEGIN
        UPDATE users
        SET balance = (
          SELECT SUM(amount) FROM ticket_transactions
        )
        WHERE users.id = NEW.user_id;

        RETURN NEW;
      END;
      $BODY$
      language plpgsql;
    SQL
  end

  def create_delete_function
    <<-SQL
      CREATE OR REPLACE FUNCTION update_after_delete_tickets() RETURNS trigger AS
      $BODY$
      BEGIN
        UPDATE users
        SET balance = (
          SELECT SUM(amount) FROM ticket_transactions
        )
        WHERE users.id = OLD.user_id;

        RETURN OLD;
      END;
      $BODY$
      language plpgsql;
    SQL
  end

  def create_trigger
    <<-SQL
      CREATE TRIGGER creating_tickets AFTER INSERT OR UPDATE
        ON ticket_transactions FOR EACH ROW EXECUTE PROCEDURE update_after_create_tickets();
      CREATE TRIGGER deleting_tickets AFTER DELETE
        ON ticket_transactions FOR EACH ROW EXECUTE PROCEDURE update_after_delete_tickets();
    SQL
  end
end
