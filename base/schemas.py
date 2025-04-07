from ninja import Schema
from pydantic import EmailStr

class ContactFormSchema(Schema):
    name: str
    email: EmailStr
    subject: str
    message: str