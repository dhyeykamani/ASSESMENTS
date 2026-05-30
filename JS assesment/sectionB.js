import React, { useState, useEffect } from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';

const BioLinkBuilder = () => {
  // 1. Link Object & Input: State management
  const [links, setLinks] = useState([]);
  const [title, setTitle] = useState('');
  const [url, setUrl] = useState('');
  const [error, setError] = useState('');

  // 4. LocalStorage Persistence: Load data on component mount
  useEffect(() => {
    const savedLinks = JSON.parse(localStorage.getItem('bioLinks')) || [];
    setLinks(savedLinks);
  }, []);

  // 4. LocalStorage Persistence: Save data whenever the 'links' array changes
  useEffect(() => {
    localStorage.setItem('bioLinks', JSON.stringify(links));
  }, [links]);

  // 2. URL Validation: Regex to check for https://
  const isValidUrl = (string) => {
    const urlPattern = /^https:\/\/.+/i;
    return urlPattern.test(string);
  };

  // Handle Form Submission
  const handleSubmit = (e) => {
    e.preventDefault();

    // Basic empty check
    if (!title.trim() || !url.trim()) {
      setError('Both Title and URL are required.');
      return;
    }

    // Trigger URL validation
    if (!isValidUrl(url)) {
      setError('Invalid URL format. It must start with https://');
      return;
    }

    // Create the object {title, url} (adding an ID for React keys and deletion)
    const newLink = {
      id: Date.now(), 
      title: title.trim(),
      url: url.trim()
    };

    // Add to array and reset form
    setLinks([...links, newLink]);
    setTitle('');
    setUrl('');
    setError('');
  };

  // 5. Delete Action: Remove item and instantly update state/storage
  const handleDelete = (id) => {
    const updatedLinks = links.filter(link => link.id !== id);
    setLinks(updatedLinks);
  };

  return (
    <div className="container mt-5">
      <h2 className="text-center mb-4 fw-bold">Creator Profile Link Manager</h2>
      
      <div className="row g-4">
        {/* LEFT COLUMN: Input Form */}
        <div className="col-md-6">
          <div className="card shadow-sm border-0">
            <div className="card-header bg-primary text-white">
              <h5 className="mb-0">Add New Link</h5>
            </div>
            <div className="card-body">
              <form onSubmit={handleSubmit}>
                <div className="mb-3">
                  <label htmlFor="titleInput" className="form-label fw-bold">Link Title</label>
                  <input
                    type="text"
                    className="form-control"
                    id="titleInput"
                    placeholder="e.g., My Portfolio"
                    value={title}
                    onChange={(e) => setTitle(e.target.value)}
                  />
                </div>
                <div className="mb-3">
                  <label htmlFor="urlInput" className="form-label fw-bold">URL</label>
                  <input
                    type="text"
                    className="form-control"
                    id="urlInput"
                    placeholder="https://example.com"
                    value={url}
                    onChange={(e) => setUrl(e.target.value)}
                  />
                </div>
                
                {/* 2. URL Validation Error Message */}
                {error && <div className="alert alert-danger py-2">{error}</div>}
                
                <button type="submit" className="btn btn-success w-100 fw-bold">
                  + Add Link
                </button>
              </form>
            </div>
          </div>
        </div>

        {/* RIGHT COLUMN: Profile Preview */}
        <div className="col-md-6">
          <div className="card shadow-lg border-0" style={{ backgroundColor: '#f8f9fa' }}>
            <div className="card-header text-center bg-dark text-white">
              <h5 className="mb-0">📱 Profile Preview</h5>
            </div>
            <div className="card-body text-center p-4">
              
              {/* Mock Profile Header */}
              <div className="mb-4">
                <div 
                  className="rounded-circle bg-secondary mx-auto d-flex align-items-center justify-content-center text-white shadow-sm mb-3" 
                  style={{ width: '90px', height: '90px', fontSize: '32px' }}>
                  👤
                </div>
                <h5 className="fw-bold">@your_username</h5>
                <p className="text-muted small">Welcome to my links page!</p>
              </div>

              {/* 3. Dynamic Rendering Area */}
              <div className="d-flex flex-column gap-3 px-3">
                {links.length === 0 ? (
                  <p className="text-muted fst-italic">No links added yet. Add one to see it here!</p>
                ) : (
                  links.map((link) => (
                    <div key={link.id} className="d-flex align-items-center shadow-sm rounded-pill pe-1" style={{ backgroundColor: '#fff' }}>
                      
                      {/* Clickable Button opening in a new tab */}
                      <a
                        href={link.url}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="btn btn-outline-dark flex-grow-1 text-truncate border-0 rounded-pill py-2 fw-semibold"
                        style={{ textAlign: 'center' }}
                      >
                        {link.title}
                      </a>
                      
                      {/* Delete Button */}
                      <button
                        onClick={() => handleDelete(link.id)}
                        className="btn btn-danger rounded-circle d-flex align-items-center justify-content-center"
                        title="Remove Link"
                        style={{ width: '35px', height: '35px', minWidth: '35px' }}
                      >
                        &times;
                      </button>
                    </div>
                  ))
                )}
              </div>
              
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default BioLinkBuilder;