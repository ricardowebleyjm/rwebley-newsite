from ninja import Router
from .models import ContactMessage
from .schemas import ContactFormSchema


router: Router = Router(tags=["Base"])

@router.post("/contact/")
def create_contact_message(request, payload: ContactFormSchema):
    """
    Create a contact message
    """
    contact_message = ContactMessage.objects.create(**payload.dict())
    return {"success": True, "message": "Message sent successfully!"}
