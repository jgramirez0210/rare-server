class Post:
    def __init__(self, id, user_id, category_id, title, publication_date, image_url, content, approved):
        self.id = id
        self.user_id = user_id
        self.category_id = category_id
        self.title = title
        self.publication_date = publication_date
        self.image_url = image_url
        self.content = content
        self.approved = approved

    def serializer_mvp(self):
        return {
            'id': self.id,
            'user_id': self.user_id,
            'title': self.title,
            'publication_date': self.publication_date,
            'image_url': self.image_url,
            'content': self.content
        }
