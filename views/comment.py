import sqlite3
from models import Comment
import json


def create_comment(new_comment):
    """create a new comment"""
    with sqlite3.connect("./db.sqlite3") as conn:
        db_cursor = conn.cursor()
        db_cursor.execute("""
            INSERT INTO Comments
            (author_id, post_id, content)
            VALUES (?, ?, ?)""",
                          (new_comment['author_id'],
                           new_comment['post_id'], new_comment['content'],)
                          )
        id = db_cursor.lastrowid
        new_comment['id'] = id
    return new_comment

def get_all_comments():
    """get all comments"""
    with sqlite3.connect("./db.sqlite3") as conn:
        conn.row_factory = sqlite3.Row
        db_cursor = conn.cursor()
        db_cursor.execute("""
            SELECT
                c.id,
                c.author_id,
                c.post_id,
                c.content
            FROM Comments c
            """)
        comments = []
        dataset = db_cursor.fetchall()
        for row in dataset:
            comment = Comment(row['id'], row['author_id'], row['post_id'], row['content'])
            comments.append(comment.__dict__)

    return comments

def get_single_comment(id):
    """get a single comment"""
    with sqlite3.connect("./db.sqlite3") as conn:
        conn.row_factory = sqlite3.Row
        db_cursor = conn.cursor()
        db_cursor.execute("""
            SELECT
                c.id,
                c.author_id,
                c.post_id,
                c.content
            FROM Comments c
            WHERE c.id = ?
            """, (id,))

        data = db_cursor.fetchone()

        comment = Comment(data['id'], data['author_id'], data['post_id'], data['content'])

    return comment.__dict__

def delete_comment(id):
    """delete a comment"""
    with sqlite3.connect("./db.sqlite3") as conn:
        db_cursor = conn.cursor()
        db_cursor.execute("""
            DELETE FROM Comments
            WHERE id = ?
            """, (id,))

    return 'Comment deleted'

def update_comment(id, new_comment):
    """update a comment"""
    with sqlite3.connect("./db.sqlite3") as conn:
        db_cursor = conn.cursor()
        db_cursor.execute("""
            UPDATE Comments
            SET
                author_id = ?,
                post_id = ?,
                content = ?
            WHERE id = ?
            """, (new_comment['author_id'], new_comment['post_id'], new_comment['content'], id,))

    rows_affected = db_cursor.rowcount

    if rows_affected == 0:
        return False
    else:
        return True