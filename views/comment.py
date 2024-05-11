import sqlite3
from models import User, SerializedUserManagement
from models import Comment
from models import Post
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
            comment = Comment(row['id'], row['author_id'],
                              row['post_id'], row['content'])
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
                c.content,
                p.id, post_id,
                p.user_id  post_user_id,
                p.category_id  post_category_id,
                p.title post_title,
                p.publication_date  post_publication_date,
                p.image_url  post_image_url,
                p.content  post_content,
                p.approved post_approved,
                u.id user_id,
                u.first_name user_first_name,
                u.last_name user_last_name,
                u.email user_email,
                u.bio user_bio,
                u.username user_username,
                u.password user_password,
                u.profile_image_url user_profile_image_url,
                u.created_on user_created_on,
                u.active  user_active
                FROM Comments c
                JOIN Posts p
                JOIN Users u
                ON c.post_id = p.id AND c.author_id = u.id
                WHERE c.id = ?
                """, (id,))

        data = db_cursor.fetchone()

        if data is None:
            return "comments Or Post not found"

        comment = Comment(data['id'], data['author_id'],
                          data['post_id'], data['content'])

        post = Post(
            data["post_id"],
            data["post_user_id"],
            data["post_category_id"],
            data["post_title"],
            data["post_publication_date"],
            data["post_image_url"],
            data["post_content"],
            data["post_approved"]
        )

        user = User(
            data["user_id"],
            data["user_first_name"],
            data["user_last_name"],
            data["user_email"],
            data["user_bio"],
            data["user_username"],
            data["user_password"],
            data["user_profile_image_url"],
            data["user_created_on"],
            data["user_active"]
        )

        comment.post = post.serializer_mvp()


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
                c.content,
                p.id, post_id,
                p.user_id  post_user_id,
                p.category_id  post_category_id,
                p.title post_title,
                p.publication_date  post_publication_date,
                p.image_url  post_image_url,
                p.content  post_content,
                p.approved post_approved,
                u.id user_id,
                u.first_name user_first_name,
                u.last_name user_last_name,
                u.email user_email,
                u.bio user_bio,
                u.username user_username,
                u.password user_password,
                u.profile_image_url user_profile_image_url,
                u.created_on user_created_on,
                u.active  user_active
                FROM Comments c
                JOIN Posts p
                JOIN Users u
                ON c.post_id = p.id AND c.author_id = u.id
                WHERE c.id = ?
                """, (id,))

        data = db_cursor.fetchone()

        if data is None:
            return "comments Or Post not found"

        comment = Comment(data['id'], data['author_id'],
                          data['post_id'], data['content'])

        post = Post(
            data["post_id"],
            data["post_user_id"],
            data["post_category_id"],
            data["post_title"],
            data["post_publication_date"],
            data["post_image_url"],
            data["post_content"],
            data["post_approved"]
        )

        user = User(
            data["user_id"],
            data["user_first_name"],
            data["user_last_name"],
            data["user_email"],
            data["user_bio"],
            data["user_username"],
            data["user_password"],
            data["user_profile_image_url"],
            data["user_created_on"],
            data["user_active"]
        )

        comment.post = post.serializer_mvp()
        user_filtered = SerializedUserManagement(
            user.username, user.first_name, user.last_name, user.email)

        comment.author = user_filtered.__dict__

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
